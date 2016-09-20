require 'rspec'
require 'httparty'
require 'pry'

describe HTTParty do


=begin
  before(:all) do
    i = 1
    6.times do
      todo() = HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{title: "Test todo #{i}", due: Date.today + 1 })
      binding.pry
      i = i + 1
    end

  end

=end

  todo1 = HTTParty.post url("todos"), query:{title: "Test todo 1", due:Date.today + 1}
  todo2 = HTTParty.post url("todos"), query:{title: "Test todo 2", due:Date.today + 1}
  todo3 = HTTParty.post url("todos"), query:{title: "Test todo 3", due:Date.today + 1}


  ###  GET Methods Testing

  it "Get whole list of todos" do

    r = HTTParty.get url("todos")
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"

  end

  it "Get specific todo" do

    r = HTTParty.get url("todos/#{todo1['id']}")
    expect(r.code).to eq 200
    expect(r.message).to eq "OK"
    expect(r['id']).to eq todo1['id']
    expect(r['title']).to eq todo1['title']
    expect(r['due']).to eq todo1['due']

  end

  it "get invalid ID todo" do

    r = HTTParty.get url("todos/9999")
    expect(r.code).to eq 404
    expect(r.message).to eq "Not Found"

  end

  it "get long ID" do

    r = HTTParty.get url("todos/79609876554337887667")
    expect(r.code).to eq 404
    expect(r.message).to eq "Not Found"

  end

  ### PATCH Methods Testing

  it "Update title of item with valid ID" do

    r1 = HTTParty.patch url("todos/#{todo1['id']}"), query:{title:"Buy Stuff"}
    expect(r1.code).to eq 200
    expect(r1.message).to eq "OK"
    expect(r1['id']).to eq todo1['id']
    expect(r1['title']).to eq "Buy Stuff"
    expect(r1['due']).to eq "#{Date.today + 1}"

  end

  it "Update title of item with invalid ID" do

    r2 = HTTParty.patch url("todos/50"), query:{title:"Buy Stuff"}
    expect(r2.code).to eq 404
    expect(r2.message).to eq "Not Found"

  end

  it "Update due date of item with valid ID" do

    r3 = HTTParty.patch url("todos/#{todo1['id']}"), query:{due:Date.today + 2}
    expect(r3.code).to eq 200
    expect(r3.message).to eq "OK"
    expect(r3['id']).to eq todo1['id']
    expect(r3['title']).to eq "Buy Stuff"
    expect(r3['due']).to eq Date.today + 2

  end

  it "Update due date of item with past date" do

    r4 = HTTParty.patch url("todos/#{todo1['id']}"), query:{due:"2002-02-13"}
    expect(r4.code).to eq 400
    expect(r4.message).to eq "Bad Request. Date not in future."

  end

  it "Update title with nil values" do

    r5 = HTTParty.patch url("todos/#{todo1['id']}"), query:{title:nil}
    expect(r5.code).to eq 405
    expect(r5.message).to eq 'Method Not Allowed'

  end

  ### PUT Methods Testing

  it "Update whole item with valid ID" do


    put = HTTParty.put url("todos/#{todo1['id']}"), query:{title: "Hello John", due: "24-09-2016"}
    expect(put.code).to eq 200
    expect(put.message).to eq "OK"
    expect(put['title']).to eq "Hello John"
    expect(put['due']).to eq "#{Date.today + 4}"


  end

  it "Attempt update of item with invalid number ID" do

    put1 = HTTParty.put url("todos/9999"), query:{title: "Hello John", due: "24-09-2016"}
    expect(put1.code).to eq 404
    expect(put1.message).to eq "Not Found"

  end

  it "Attempt update of item with invalid letter/character ID" do

    put2 = HTTParty.put url("todos/aaaa"), query:{title: "Hello John", due: "24-09-2016"}
    expect(put2.code).to eq 404
    expect(put2.message).to eq "Not Found. ID Only accepts numbers."

  end

  it "Attempt update without ID" do

    put3 = HTTParty.put url("todos"), query:{title: "Hello John", due: "24-09-2016"}
    expect(put3.code).to eq 405
    expect(put3.message).to eq "Method Not Allowed"

  end

  it "update with nil values including title" do


    put4 = HTTParty.put url("todos/#{todo1['']}"), query:{title: nil, due: nil}
    expect(put4.code).to eq 400
    expect(put4.message).to eq "Bad Request. Title Not Given."

  end

  it "update with nil values in due date" do


    put5 = HTTParty.put url("todos/#{todo1['id']}"), query:{title: "Tester", due: nil}
    expect(put5.code).to eq 200
    expect(put5.message).to eq "OK"
    expect(put5['due']).to eq (Date.Today + 1)

  end

  it "Update with date in past" do

    put6 = HTTParty.put url("todos/#{todo1['id']}"), query:{title: "Tester", due: "01-01-1970"}
    expect(put6.code).to eq 400
    expect(put6.message).to eq "Bad Request. Date Not In Future."

  end


  ###  DELETE METHODS TESTS
  it "Delete with valid ID" do

    del1 = HTTParty.delete("http://lacedeamon.spartaglobal.com/todos/#{todo5['id']}")
    expect(del1.code).to eq 204
    expect(del1.message).to eq "No Content"
    get1 = HTTParty.get("http://lacedeamon.spartaglobal.com/todos/#{todo5['id']}")
    expect(get1.code).to eq 404
    expect(get1.message).to eq "Not Found"
  end

  it "Delete with invalid ID" do

    del2 = HTTParty.delete url("todos/#{todo1['id']}")
    expect(del2.code).to eq 404
    expect(del2.message).to eq "Not Found"

  end

  it "Delete without ID/ Whole list" do

    del3 = HTTParty.delete url("todos")
    expect(del3.code).to eq 405
    expect(del3.message).to eq "Method Not Allowed"


  end





  ### POST METHOD TESTS


  it "Valid creating new todo" do

    post1 = HTTParty.post('http://lacedeamon.spartaglobal.com/todos', query:{title: "Test POST 1", due: Date.today + 1 })
    expect(post1.code).to eq 201
    expect(post1.message).to eq "Created"
    expect(post1['title']).to eq "Test POST 1"
    expect(post1['due']).to eq "#{Date.today + 1}"


  end

  it "Try to create against todos/id" do

    post2 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos/#{todo1['id']}", query:{title: "Test POST 2", due: Date.today + 1 })
    expect(post2.code).to eq 405
    expect(post2.message).to eq "Method Not Allowed"
    expect(post2.body).to eq "Method Not Allowed. To create a new todo, POST to the collection, not an item within it."

  end

  it "Try to create with invalid parameters" do

    post3 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query:{title: nil, due: nil })
    expect(post3.code).to eq 400
    expect(post3.message).to eq "Bad Request. Invalid Parameters"

  end

  it "Try to create with too few arguments" do

    post4 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos")
    expect(post4.code).to eq 422
    expect(post4.message).to eq "Unprocessable Entity"

  end

  it "Try to create with too many arguments" do

    post5 = HTTParty.post("http://lacedeamon.spartaglobal.com/todos", query:{title: "asdfasdf", hello: "asdfausadhf", lotsofparams: "asdfasdfahhfa", somany: "asdfhdssrt", })
    expect(post5.code).to eq 422
    expect(post5.message).to eq "Unprocessable Entity"

  end

  after(:all) do
    delete_all()
  end


end
