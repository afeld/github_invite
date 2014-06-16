module InvitesHelper
  def simple_date(time)
    # http://stackoverflow.com/a/165213/358804
    time.strftime("%b #{time.day.ordinalize}")
  end
end
