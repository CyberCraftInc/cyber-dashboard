require 'rails_helper'

describe 'Sort users', type: :feature do
  let!(:first_user) do
    FactoryBot.create(
      :user,
      last_name: 'bbb',
      first_name: 'cc',
      position: 'Junior',
      birthday: '1989-10-01',
      start_in_company: '2019-11-07'
    )
  end

  let!(:second_user) do
    FactoryBot.create(
      :user,
      last_name: 'ccc',
      first_name: 'aa',
      position: 'Senior',
      birthday: '1989-11-12',
      start_in_company: '2018-11-07'
    )
  end

  let!(:third_user) do
    FactoryBot.create(
      :user,
      last_name: 'aaa',
      first_name: 'bb',
      position: 'CEO',
      birthday: '1989-12-09',
      start_in_company: '2017-11-07'
    )
  end

  before do
    sign_in(first_user)
  end

  it 'has sort buttons', js: true do
    page.has_button?('position')
    page.has_button?('birthday')
    page.has_button?('days in company')
  end

  it 'sort by position value', js: true do
    default_users

    click_button('position')

    using_wait_time 10 do
      within '.users' do
        users = all('.user')

        expect(users[0]).to have_content(third_user.position)
        expect(users[1]).to have_content(second_user.position)
        expect(users[2]).to have_content(first_user.position)
      end
    end
  end

  it 'sort by birthday value', js: true do
    default_users
    users_sorted = sort_by_birthday([first_user, second_user, third_user])

    click_button('birthday')

    using_wait_time 10 do
      within '.users' do
        users = all('.user')

        expect(users[0]).to have_content(users_sorted.first.position)
        expect(users[1]).to have_content(users_sorted.second.position)
        expect(users[2]).to have_content(users_sorted.last.position)
      end
    end
  end

  it 'sort by days in company value', js: true do
    default_users

    click_button('days in company')

    using_wait_time 10 do
      within '.users' do
        users = all('.user')

        expect(users[0]).to have_content(third_user.position)
        expect(users[1]).to have_content(second_user.position)
        expect(users[2]).to have_content(first_user.position)
      end
    end
  end

  private

  def default_users
    within '.users' do
      users = all('.user')

      expect(users[0]).to have_content(first_user.position)
      expect(users[1]).to have_content(second_user.position)
      expect(users[2]).to have_content(third_user.position)
    end
  end

  def click_on_first_name_head
    page.all('thead span')[1].click
  end

  def sort_by_birthday(users)
    users.sort! do |user, next_user|
      user = format_date(month: user.birthday.month, day: user.birthday.day)
      next_user = format_date(month: next_user.birthday.month, day: next_user.birthday.day)
      user <=> next_user
    end
  end

  def format_date(date)
    current_date = Time.zone.today

    date.each do |key, value|
      if (current_date.month > date[:month]) || (current_date.month == date[:month] && current_date.day > date[:day])
        date[key] += 10_000
      end
      date[key] = "0#{value}" if value <= 9
    end

    "#{date[:month]}#{date[:day]}".to_i
  end
end
