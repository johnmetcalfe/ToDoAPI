require 'rspec'
require 'httparty'
require 'pry'

describe HTTParty do

  todo1 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query:{title: "Test todo 1", due:Date.today + 1})
  todo2 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query:{title: "Test todo 2", due:Date.today + 1})
  todo3 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query:{title: "Test todo 3", due:Date.today + 1})

  it "Update title of item with valid ID" do
    r1 = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/7959", query:{title:"Buy Stuff"}
    expect(r1.code).to eq 200
    expect(r1.message).to eq "OK"
    expect(r1['id']).to eq 7959
    expect(r1['title']).to eq "Buy Stuff"
    expect(r1['due']).to eq "2016-09-27"
  end

  it "Update title of item with invalid ID" do
    r2 = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/50", query:{title:"Buy Stuff"}
    expect(r2.code).to eq 404
    expect(r2.message).to eq "Not Found"
  end

  it "Update due date of item with valid ID" do
    r3 = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/7959", query:{due:"2017-02-13"}
    expect(r3.code).to eq 200
    expect(r3.message).to eq "OK"
    binding.pry
    expect(r3['id']).to eq 7959
    expect(r3['title']).to eq "Buy Stuff"
    expect(r3['due']).to eq "2017-02-13"
  end

  it "Update due date of item with past date" do
    r4 = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/7959", query:{due:"2002-02-13"}
    expect(r2.code).to eq 400
    expect(r2.message).to eq "Bad Request. Date not in future."
  end

  it "update title with nil values" do
    r5 = HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/7959", query:{title:nil}
    expect(r5.code).to eq 405
    expect(r5.message).to eq 'Method Not Allowed'
  end




end
