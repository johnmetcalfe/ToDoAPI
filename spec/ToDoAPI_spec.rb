require 'rspec'
require 'httparty'
require 'date'

describe HTTParty do

  todo1 = HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{title: "Test todo 1", due: Date.today + 1 })
  todo2 = HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{title: "Test todo 2", due: Date.today + 1 })
  todo3 = HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{title: "Test todo 3", due: Date.today + 1 })

  ###  GET Methods Testing

  it "Get whole list of todos" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos')
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"

  end

  it "Get specific todo" do

    r = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{todo1['id']}")
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"
    expect(r['id']).to eq todo1['id']
    expect(r['title']).to eq todo1['title']
    expect(r['due']).to eq todo1['due']

  end

  it "get invalid ID todo" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos/9999')
    expect(r.code).to eq 404
    expect(r.message).to eq "Not Found"

  end

  it "get long ID" do

    r = HTTParty.get('http://lacedeamon.spartaglobal.com/todos/79609876554337887667')
    expect(r.code).to eq 404
    expect(r.message).to eq "Not Found"

  end

  ### PUT Methods Testing

  it "Update whole item with valid ID" do

    put = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/7956', query:{title: "Hello John", due: "24-09-2016"})
    expect(put.code).to eq 200
    expect(put.message).to eq "OK"
    expect(put['title']).to eq "Hello John"
    expect(put['due']).to eq "2016-09-24"


  end

  it "Attempt update of item with invalid number ID" do

    put1 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/9999', query:{title: "Hello John", due: "24-09-2016"})
    expect(put1.code).to eq 404
    expect(put1.message).to eq "Not Found"

  end

  it "Attempt update of item with invalid letter/character ID" do

    put2 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/aaaa', query:{title: "Hello John", due: "24-09-2016"})
    expect(put2.code).to eq 404
    expect(put2.message).to eq "Not Found. ID Only accepts numbers."

  end

  it "Attempt update without ID" do

    put3 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos', query:{title: "Hello John", due: "24-09-2016"})
    expect(put3.code).to eq 405
    expect(put3.message).to eq "Method Not Allowed"

  end

  it "update with nil values including title" do

    put4 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/7592', query:{title: nil, due: nil})
    expect(put4.code).to eq 400
    expect(put4.message).to eq "Bad Request. Title Not Given."

  end

  it "update with nil values in due date" do

    put5 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/7950', query:{title: "Tester", due: nil})
    expect(put5.code).to eq 200
    expect(put5.message).to eq "OK"
    expect(put5.due).to eq (Date.Today + 1)

  end

  it "Update with date in past" do

    put6 = HTTParty.put('http://lacedeamon.spartaglobal.com/todos/7934', query:{title: "Tester", due: "01-01-1970"})
    expect(put6.code).to eq 400
    expect(put6.message).to eq "Bad Request. Date Not In Future."

  end


  ###  DELETE METHODS TESTS
=begin
  it "Delete with valid ID" do

    del1 = HTTParty.delete('http://lacedeamon.spartaglobal.com/todos/7902')
    expect(del1.code).to eq 204
    expect(del1.message).to eq "No Content"
    get1 = HTTParty.get('http://lacedeamon.spartaglobal.com/todos/7902')
    expect(get1.code).to eq 404
    expect(get1.message).to eq "Not Found"
    HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{id: 7902, title: "Hello John", due: "24-09-2016"})

  end
=end

  it "Delete with invalid ID" do

    del2 = HTTParty.delete('http://lacedeamon.spartaglobal.com/todos/9999')
    expect(del2.code).to eq 404
    expect(del2.message).to eq "Not Found"

  end

  it "Delete without ID/ Whole list" do

    del3 = HTTParty.delete('http://lacedeamon.spartaglobal.com/todos')
    expect(del3.code).to eq 405
    expect(del3.message).to eq "Method Not Allowed"

  end




  ### POST METHOD TESTS


  it "Valid creating new todo" do

  end

  it "Try to create against todos/id" do

  end

  it "Try to create with invalid parameters" do

  end

  it "Try to create with too few arguments" do

  end

  it "Try to create with too many arguments" do

  end


end
