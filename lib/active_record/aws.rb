require "active_record"
require "active_record/aws/version"

module ActiveRecord
  class Base
    class << self
      def decrypt_password
        Migration.stage :DecryptPassword do |stage|
          stage.step :kms_decrypt, :ciphertext do
            blob      = Base64.decode64 connection_config[:ciphertext]
            decrypted = Aws::KMS::Client.new.decrypt ciphertext_blob:blob
            connection_config.update password:decrypted[:plaintext]
          end
        end
      end

      def encrypted_password?
        connection_config[:ciphertext]
      end
    end
  end

  class Migration
    class << self
      def stage name
        start = Time.now.utc
        puts "== #{start.strftime('%Y%m%d%H%M%S')} #{name}: begin ".ljust 79, '='
        result = yield self
        puts "== #{start.strftime('%Y%m%d%H%M%S')} #{name}: end "\
             "(#{Time.now.utc - start}) ".ljust 79, '='
        puts
        result
      end

      def step method, name
        puts "-- #{method}(#{name.to_sym.inspect})"
        start  = Time.now.utc
        result = yield
        puts "   -> #{Time.now.utc - start}"
        result
      end
    end
  end
end
