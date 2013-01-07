#
#  Helpers for rake tasks.
#
#  GemInfo - class where info about gem is stored.
#
#  TestAppChecker - helps to check if test app is ready for testing
#

class GemInfo
  def self.gem_root
    @netzke_gem_root ||= File.expand_path('../..', __FILE__)
  end
  def self.test_app_root
    @test_app_root   ||= File.join(gem_root, 'test', 'basepack_test_app')
  end
end


class TestAppChecker
  def self.extjs_installed?
    File.exists?(File.join(GemInfo.test_app_root, 'public', 'extjs'))
  end

  def self.database_config_exists?
    File.exists?(File.join(GemInfo.test_app_root, 'config', 'database.yml'))
  end

  def self.database_exists?
    # File.exists?(File.join(GemInfo.test_app_root, 'db', 'development.sqlite3'))
    ["/opt/local/var/run/mysql5/mysqld.sock", "/tmp/mysqld.sock", "/tmp/mysql.sock", "/var/run/mysqld/mysqld.sock", "/var/lib/mysql/mysql.sock"].detect{ |socket| File.exist?(socket) }
  end

  def self.ready?
    self.extjs_installed? && self.database_config_exists? && self.database_exists?
  end
end

# colorization
class String

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end
end