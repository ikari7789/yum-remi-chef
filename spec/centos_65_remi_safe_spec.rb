require 'spec_helper'

describe 'yum-remi-chef::remi-safe' do
  cached(:centos_65_remi_safe) do
    ChefSpec::ServerRunner.new(
      platform: 'centos',
      version: '6.5'
    ) do |node|
      node.normal['yum']['remi-safe']['enabled'] = true
      node.normal['yum']['remi-safe']['managed'] = true
    end.converge(described_recipe)
  end

  %w(
    remi-safe
  ).each do |repo|
    it "creates yum_repository[#{repo}]" do
      expect(centos_65_remi_safe).to create_yum_repository(repo)
    end
  end
end
