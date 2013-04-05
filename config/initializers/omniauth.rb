Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'C0XihXynY4To2MXL6Ix0mA', 'RlDnqYtwVr8kuhgdCD6sSKhdl52afab3w3ZhXHYszE'
  provider :facebook, '	396205170468409', '724245adc1b0ce7255b2a51e35a3142d'
  provider :google_oauth2, '193587488444.apps.googleusercontent.com', 'LWPkbQmBz-v9EzmnVF3Cdsy_', { access_type: "offline", approval_prompt: "" }

end