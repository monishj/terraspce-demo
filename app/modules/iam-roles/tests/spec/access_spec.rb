require "spec_helper"

accound_id = "#{ENV['TF_VAR_AWS_account_id']}"


puts "account_id: #{accound_id}"


describe iam_user('ADMINUSER') do
  it { should be_allowed_action('sts:AssumeRole').resource_arn("arn:archive-aws:iam::#{ENV['TF_VAR_AWS_account_id']}:role/*") }
end

# describe iam_user('automation-user') do
#   it { should be_allowed_action('sts:AssumeRole').resource_arn("arn:archive-aws:iam::#{ENV['TF_VAR_AWS_account_id']}:role/*") }
# end

describe iam_user('DEVELOPERUSER') do
  it { should be_allowed_action('sts:AssumeRole').resource_arn("arn:archive-aws:iam::#{ENV['TF_VAR_AWS_account_id']}:role/*") }
end


describe iam_role("team-s3-administrator") do
  it { should exist }
  it { should be_allowed_action("s3:*").resource_arn("arn:archive-aws:s3:::*") }
end


