module Octoclass
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
  end

  # use the :id for object identity
  # https://github.com/rails/rails/blob/952d0f8bdfa3f919794bf36049bafd2d95e3c97b/activerecord/lib/active_record/core.rb#L361-L386

  # Returns true if +comparison_object+ is the same exact object, or +comparison_object+
  # is of the same type and +self+ has an ID and it is equal to +comparison_object.id+.
  def ==(comparison_object)
    super ||
      comparison_object.instance_of?(self.class) &&
      !id.nil? &&
      comparison_object.id == id
  end
  alias :eql? :==

  def hash
    if id
      id.hash
    else
      super
    end
  end
end
