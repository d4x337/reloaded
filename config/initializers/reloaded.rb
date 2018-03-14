Reloaded::Application.config.default_key = if Rails.env.development? or Rails.env.test?
                                            '52322e03ef3f49487ac8275557afc4d983e0939f813aa304fe53519d79208f28bc7c33ab064f6622dbb2b09a5c791a85d6dd24f86dce5bbd6db530ebbd8bf4fd'
                                          else
                                             ENV['RELOADED_DEFAULT_KEY']
                                          end
Reloaded::Application.config.vector_init_tripledes = if Rails.env.development? or Rails.env.test?
                                                      '999337000'
                                                    else
                                                      ENV['RELOADED_VECTOR_INIT_TRIPLEDES']
                                                    end
Reloaded::Application.config.vector_init_twofish = if Rails.env.development? or Rails.env.test?
                                                    '1234123412341234123412341234123412341234123412341234123412341234'
                                                  else
                                                    ENV['RELOADED_VECTOR_INIT_TWOFISH']
                                                  end
Reloaded::Application.config.default_key_twofish = if Rails.env.development? or Rails.env.test?
                                                    ' (expecting 16, 24 or 32 bytes) '
                                                  else
                                                    ENV['RELOADED_DEFAULT_KEY_TWOFISH']
                                                 end
Reloaded::Application.config.default_key_tripledes = if Rails.env.development? or Rails.env.test?
                                                   '6814321a093473730e4288f145bae9cb608827b9337a55d796748f673ba6303738d7f9a14f8b33ee03dddc21645539d6ed615dbec436e6e88e69bfe5c5f29084'
                                                 else
                                                   ENV['RELOADED_DEFAULT_KEY_TRIPLEDES']
                                                 end
Reloaded::Application.config.default_key_aes = if Rails.env.development? or Rails.env.test?
                                                '6814321a123473730e4288f145bae9cb608827b9337a55d796748f673ba6303738d7f9a14f8b33ee03dddc21645539d6ed615dbec436e6e88e69bfe5c5f29084'
                                              else
                                                ENV['RELOADED_DEFAULT_KEY_AES']
                                              end
Reloaded::Application.config.shared_stored = if Rails.env.development? or Rails.env.test?
                                               'asdfkasdbasdfas2423SAFNKLNFDSLK sadkfeoihfasdfasdf234523hovigzàndklvhnasdogifwerio'
                                             else
                                               ENV['RELOADED_VECTOR_KEY_AES']
                                            end


