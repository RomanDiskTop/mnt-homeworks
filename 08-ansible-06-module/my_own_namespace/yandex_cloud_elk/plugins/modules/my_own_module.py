#!/usr/bin/python

from __future__ import absolute_import, division, print_function
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_module

short_description: Create text file with content

version_added: "1.0.0"

description:
  - This module creates a text file on a remote host.
  - File path is defined by path parameter.
  - File content is defined by content parameter.

options:
  path:
    description:
      - Path to the file that should be created.
    required: true
    type: str
  content:
    description:
      - Content that should be written to the file.
    required: true
    type: str

author:
  - Roman (@dog540705)
'''

EXAMPLES = r'''
- name: Create test file
  my_own_namespace.yandex_cloud_elk.my_own_module:
    path: /tmp/test_file.txt
    content: "Hello from custom Ansible module"
'''

RETURN = r'''
path:
  description: Path to created file.
  type: str
  returned: always
content:
  description: File content.
  type: str
  returned: always
changed:
  description: Whether file was changed.
  type: bool
  returned: always
'''

import os
from ansible.module_utils.basic import AnsibleModule


def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True),
    )

    result = dict(
        changed=False,
        path='',
        content='',
        message='',
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path = module.params['path']
    content = module.params['content']

    result['path'] = path
    result['content'] = content

    current_content = None

    if os.path.exists(path):
        try:
            with open(path, 'r') as file:
                current_content = file.read()
        except Exception as e:
            module.fail_json(msg=f"Failed to read file: {e}", **result)

    if current_content == content:
        result['changed'] = False
        result['message'] = 'File already exists with the same content'
        module.exit_json(**result)

    result['changed'] = True

    if module.check_mode:
        result['message'] = 'File would be created or updated'
        module.exit_json(**result)

    try:
        directory = os.path.dirname(path)
        if directory and not os.path.exists(directory):
            os.makedirs(directory)

        with open(path, 'w') as file:
            file.write(content)

        result['message'] = 'File created or updated successfully'
    except Exception as e:
        module.fail_json(msg=f"Failed to write file: {e}", **result)

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
