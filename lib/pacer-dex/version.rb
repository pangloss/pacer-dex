module Pacer
  module Dex
    # Dex segfaults for me under Java 1.7... YMMV
    if not defined? ENABLED
      ENABLED = ENV_JAVA['java.runtime.version'] =~ /^1\.6\./
    end
    VERSION = "2.0.2"
    JAR = "pacer-dex-#{ VERSION }-standalone.jar"
    JAR_PATH = "lib/#{ JAR }"
    BLUEPRINTS_VERSION = "2.1.0"
    PIPES_VERSION = "2.1.0"
    PACER_REQ = ">= 1.0.0"
  end
end
