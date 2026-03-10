(setq telega-proxies
      (list
       '(:server "localhost" :port 8440 :enable t
                 :type ( :@type "proxyTypeMtproto"
                         :secret "d676d59cd211bfe0031e4db3debc6a1b"))
       '(:server "localhost" :port 8441 :enable :false
                 :type ( :@type "proxyTypeMtproto"
                         :secret "1b3e58008e4a2838505ea99838db21df"))))
