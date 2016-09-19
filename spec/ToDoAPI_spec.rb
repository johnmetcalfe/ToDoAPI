require 'rspec'
require 'httparty'

describe HTTParty do

  it "Get whole list of todos" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos')
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"

  end

  it "Get specific todo" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos/7960')
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"
    expect(r['id']).to eq 7960
    expect(r['title']).to eq "Alex Test Two"
    expect(r['due']).to eq "2028-01-16"
    expect(r['created_at']).to eq "2016-09-19T12:55:10.855Z"
    expect(r['updated_at']).to eq "2016-09-19T12:55:10.855Z"

  end

  it "get invalid ID todo" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos/9999')

  end

end
