#!/usr/bin/env ruby
# encoding: utf-8

require_relative "./lib/ssh_key"

def check_for_required_vars
  raise "PLAYBOOK is required" unless ENV["PLAYBOOK"]
  raise "HOST is required" unless ENV["HOST"]
  raise "KEY is required" unless ENV["KEY"]
end

playbook = ENV["PLAYBOOK"]
host = ENV["HOST"]
key = ENV["KEY"]

SshKey.new(key).create_key_for_connection

check_for_required_vars

# system "ansible --version"
system "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '#{host},' playbooks/v1/#{playbook}"

