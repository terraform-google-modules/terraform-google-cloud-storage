#!/usr/bin/env python3

import argparse
import collections
import json
import sys


Resource = collections.namedtuple('Resource', 'module type name each items')

parser = argparse.ArgumentParser(description='Migrate cloud storage module.')
parser.add_argument('-m', '--module', required=True, help='module name')
parser.add_argument('-n', '--names', required=True, action='append',
                    help='name in module names variable')
parser.add_argument('--apply-changes', action='store_true',
                    help='apply changes')


def dump_state(state, changes):
  "Applies changes and dumps modified state to stdout."
  for resource, indexes, keys in changes:
    resource['each'] = 'map'
    for i, instance in enumerate(resource['instances']):
      instance['index_key'] = keys[i]
  json.dump(state, sys.stdout, indent=2)


def _find_module_resources(state, mod_name):
  "Find and return resources in specified module with 'each': 'list'."
  for resource in state['resources']:
    if resource['module'] == mod_name and resource.get('each') == 'list':
      yield resource


def get_args():
  "Get argparse args and run minimal checks on their values."
  args = parser.parse_args()
  if len(set(args.names)) != len(args.names):
    raise SystemExit('Duplicate name in arguments.')
  return args


def load_state():
  "Load JSON state from standard input."
  try:
    return json.load(sys.stdin)
  except json.JSONDecodeError as e:
    raise SystemExit('JSON decoding error. %s' % e)


def format_changes(changes):
  "Get formatted list of changes for optional user confirmation."
  headers = ('module', 'type', 'name', 'old indexes', 'new indexes')
  changes = [
      (c[0]['module'], c[0]['type'], c[0]['name']) + c[1:] for c in changes
  ]
  pads = tuple(
      max(len(c[i]) for c in changes + [headers]) for i in range(len(headers))
  )
  yield ' '.join(headers[i].ljust(p) for i, p in enumerate(pads))
  yield ' '.join('-' * p for p in pads)
  for change in changes:
    yield ' '.join(str(change[i]).ljust(p) for i, p in enumerate(pads))


def get_changes(names, resources):
  "Check number of resource instances matches names."
  num = len(names)
  for resource in resources:
    path = '.'.join((resource['module'], resource['type'], resource['name']))
    indexes = [i['index_key'] for i in resource['instances']]
    if len(indexes) and len(indexes) != num:
      raise SystemExit('Number of instances in %s does not match names: %s.' % (
          path, indexes))
    yield resource, indexes, names if indexes else []


def show_output(changes, apply_changes=False):
  "Show user output reflecting changes."
  if not changes:
    print('No changes to perform.', file=sys.stderr)
    return
  print('State changes:\n', file=sys.stderr)
  for output in format_changes(changes):
    print(output, file=sys.stderr)
  print(file=sys.stderr)
  if apply_changes:
    print('Applying changes.', file=sys.stderr)
  else:
    print('Re-run with --apply-changes to output modified state file.', file=sys.stderr)


def main():
  args = get_args()
  state = load_state()
  resources = [r for r in _find_module_resources(state, args.module)]
  changes = [c for c in get_changes(args.names, resources)]
  show_output(changes, args.apply_changes)
  if not args.apply_changes:
    return
  dump_state(state, changes)


if __name__ == '__main__':
  main()
