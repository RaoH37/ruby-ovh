# frozen_string_literal: true

module Ovh
  ENDPOINTS = {
    ovh_eu: 'https://eu.api.ovh.com/1.0',
    ovh_us: 'https://api.us.ovhcloud.com/1.0',
    ovh_ca: 'https://ca.api.ovh.com/1.0',
    kimsufi_eu: 'https://eu.api.kimsufi.com/1.0',
    kimsufi_ca: 'https://ca.api.kimsufi.com/1.0',
    soyoustart_eu: 'https://eu.api.soyoustart.com/1.0',
    soyoustart_ca: 'https://ca.api.soyoustart.com/1.0'
  }.freeze

  TIMEOUT = 180

  API_HTTP_METHODS = %i[get post put delete].freeze
end
