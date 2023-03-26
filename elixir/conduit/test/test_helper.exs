{:ok, _} = Application.ensure_all_started(:ex_machina)
ExUnit.configure(exlude: [:pending, :skip])
ExUnit.start()
