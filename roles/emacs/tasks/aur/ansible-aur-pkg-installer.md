
## About

When using ArchLinux, I typically prefer to use an AUR helper like pacaur 
or yaourt to automate away the process of installing a community package.

Ansible's [pacman module](http://docs.ansible.com/pacman_module.html) is 
great, but it doesn't support AUR packages or pacman's `-U` flag. 
Installing AUR packages with Ansible seemed to be left as an exercise to
the user, and since AUR helpers do not come with a fresh Arch install, I
created this set of tasks to be a reusable way of installing AUR packages
on my Arch hosts.

I should take the time to PR an AUR module for Ansible sometime soon, but
this is a nice, resusable submodule for any Arch-based Ansible role.

## Example

```yaml
---
- name: install yaourt on ArchLinux hosts
  hosts: my_archlinux_host_group
  gather_facts: yes
  vars:
    makepkg_nonroot_user: "{{ ansible_ssh_user }}"
  tasks:
    - name: install package-query (a yaourt dependency)
      include: aur/pkg.yml pkg_name=package-query
      
    - name: install yaourt
      include: aur/pkg.yml pkg_name=yaourt
```

## Reccommended Usage

1. Add this gist as a submodule to your Ansible role or playbook

```sh
# Example ./roles directory structure for an existing Ansible playbook with a 'foobar' role 
#   roles/
#     foobar/
#       tasks/
#         aur/          # Source repo added as a submodule (cloned into an `aur` directory)
#           pkg.yml     # Include this file with vars 'pkg_name' and 'makepkg_nonroot_user' to install an AUR package
$ cd ./roles/foobar/tasks
$ git submodule add https://gist.github.com/45bb9eee92c5f1fce66f.git aur
```

2. Now `aur/pkg.yml` may be included from any task or handler within the foobar role.
   Given the variables `pkg_name` and `makepkg_nonroot_user`, the tasks will validate, download,
   compile (as the `makepkg_nonroot_user` user), and install (as root) the `pkg_name`
   package.

  > Tip: Set `makepkg_nonroot_user` in your `group_vars/all` file to avoid repeating yourself.
