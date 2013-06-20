require 'spec_helper'

describe ListItem do
  it { should belong_to :list }

  it { should validate_presence_of :title }
  it { should validate_presence_of :list }
end
