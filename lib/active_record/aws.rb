require "active_record/aws/version"

module ActiveRecord
  class Base
    class << self
      def decrypt_password
        blob      = Base64.decode64 connection_config[:ciphertext]
        decrypted = ::Aws::KMS::Client.new.decrypt ciphertext_blob:blob
        connection_config.update password:decrypted[:plaintext]
      end

      def encrypted_password?
        connection_config[:ciphertext]
      end
    end
  end

  class Migration
    class << self
      def decrypt_password
        stage :DecryptPassword do |stage|
          stage.step :kms_decrypt, :ciphertext do
            Base.decrypt_password
          end
        end
      end

      def stage name
        start = Time.now.utc
        puts "== #{start.strftime('%Y%m%d%H%M%S')} #{name}: begin ".ljust 79, '='
        result = yield self
        puts "== #{start.strftime('%Y%m%d%H%M%S')} #{name}: end "\
             "(#{(Time.now.utc - start).round 4}s) ".ljust 79, '='
        puts
        result
      end

      def step method, name
        puts "-- #{method}(#{name.to_s.to_sym.inspect})"
        start  = Time.now.utc
        result = yield
        puts "   -> #{(Time.now.utc - start).round 4}s"
        result
      end
    end
  end
end
