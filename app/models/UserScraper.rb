require 'Mechanize'
class UserScraper
  def get_trip_info(email, password)
    agent = Mechanize.new { |agent|
      agent.ssl_version, 
      agent.verify_mode = 'TLSv1',
      OpenSSL::SSL::VERIFY_NONE
    }

    agent.get('https://www.citibikenyc.com/') do |home|
      signin = agent.click(home.link_with(:text => /Member Login/))

      my_page = signin.form_with(:class => 'ed-popup-form_login__form') do |form|
        username_field = form.field_with(:name => '_username')
        username_field.value = email 
        password_field = form.field_with(:name => '_password')
        password_field.value = password 
      end.submit
    end
    trips_data = []

    agent.get('https://member.citibikenyc.com/profile/') do |t|

      trips_page = agent.click(t.link_with(:text => /Trips/))

    trips_data = []
    trips_page.css('.ed-table__item_trip').each do |bike|
      trip_info = {}
      trip_info = {
        start_loc: bike.css('.ed-table__item__info__sub-info_trip-start-station').text,
        end_loc: bike.css('.ed-table__item__info__sub-info_trip-end-station').text,
        start_time: bike.css('.ed-table__item__info__sub-info_trip-start-date').text, 
        end_time: bike.css('.ed-table__item__info__sub-info_trip-end-date').text, 
        duration: bike.css('.ed-table__col_trip-duration').text.strip
      }
      trips_data << trip_info
      end
      trips_data
    end
    trips_data
  end
end

