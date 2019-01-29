def setup_factories
  filenames=Dir.new("#{Rails.root}/app/models").entries.select{|e| e.match(/.rb$/)}
  modelnames=filenames.map{|fn| fn.gsub(/.rb$/,'').camelize.constantize}
  modelnames.each do |thing|
    string=thing.to_s.underscore
    symbol=string.to_sym
    symbol_persisted="#{string}_persisted".to_sym
    things=string.pluralize

    no_things="no_#{things}"
    some_things="some_#{things}"

    symbol_none= no_things.to_sym
    symbol_some= some_things.to_sym

    let(symbol){FactoryBot.build_stubbed symbol}
    let(symbol_persisted){FactoryBot.create symbol}
    let(symbol_none){thing.none}
    let(symbol_some){thing.where(id: eval(symbol_persisted.to_s).id)}
    let("params_#{string}_id".to_sym){ {"#{string}_id".to_sym =>  1} }
    let("params_full_#{string}".to_sym){ {"#{string}_id".to_sym => 1, symbol => {id: 1}} }
    if thing.respond_to?(:friendly)
      define_method "expect_to_fail_to_friendly_find_#{string}" do
        expect(thing).to receive(:friendly).at_least(:once).and_return(eval(no_things))
      end

      define_method "expect_to_friendly_find_#{string}" do
        expect(thing).to receive(:friendly).at_least(:once).and_return(eval(some_things))
        allow(eval(some_things)).to receive(:find).and_return(eval(string))
      end

      define_method "fail_to_friendly_find_#{string}" do
        allow(thing).to receive(:friendly).and_return(eval(no_things))
      end

      define_method "friendly_find_#{string}" do
        allow(thing).to receive(:friendly).and_return(eval(some_things))
        allow(eval(some_things)).to receive(:find).and_return(eval(string))
      end
    # else
      define_method "expect_to_fail_to_find_#{string}" do
        expect(thing).to receive(:find).at_least(:once).and_throw('error')
      end

      define_method "expect_to_find_#{string}" do
        expect(thing).to receive(:find).at_least(:once).and_return(eval(string))
      end

      define_method "fail_to_find_#{string}" do
        allow(thing).to receive(:find).and_throw('error')
      end

      define_method "find_#{string}" do
        allow(thing).to receive(:find).and_return(eval(string))
      end

      define_method "find_#{string}_persisted" do
        allow(thing).to receive_message_chain(string.pluralize.to_sym, :find).and_return(eval("#{string}_persisted"))
      end
    end
    let("params_new_#{string}".to_sym){ {symbol => {id: 1}} }
  end
  let(:params_id){ {id: 1} }

  def returns_200
    it "returns http success" do
      expect(response).to be_successful
    end
  end

  def sign_in_admin
    sign_in admin_persisted
    allow(controller).to receive(:current_admin).and_return admin
    allow(admin).to receive(:super_user?).and_return true
  end

  def webpacker_workaround
    allow(view).to receive(:asset_pack_path).and_return ''
    allow(view).to receive(:javascript_pack_tag).and_return ''
  end
end
