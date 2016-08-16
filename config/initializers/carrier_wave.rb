if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        # Amazon S3 的配置
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['AKIAJEIUDL4MK7PR6BYQ'],
        :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['danny-railstutorial']
  end
end