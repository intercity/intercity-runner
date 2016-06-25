#!/usr/bin/env ruby
# encoding: utf-8

require_relative "./lib/ssh_key"
require "json"
require "base64"

def check_for_required_vars
  raise "PLAYBOOK is required" unless ENV["PLAYBOOK"]
  raise "HOST is required" unless ENV["HOST"]
  raise "KEY is required" unless ENV["KEY"]
end

def parse_dokku_commands
  begin
  commands = JSON.parse(Base64.decode64(ENV["DOKKU_COMMAND"]))
  rescue JSON::ParserError
    commands = []
  end
end

def run_ansible(host, playbook, command = nil)
  ENV["DOKKU_COMMAND"] = command
  system "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '#{host},' playbooks/v1/#{playbook}"
end

playbook = ENV["PLAYBOOK"]
host = ENV["HOST"]
key = ENV["KEY"]

SshKey.new(key).create_key_for_connection

check_for_required_vars

commands = parse_dokku_commands
if commands.count > 0
  commands.each do |command|
    run_ansible(host, playbook, command)
  end
else
  run_ansible(host, playbook)
end
