#Sinatra study

### 0.version

    -ruby: 2.4.0


### 1.sinatra

    -mkdir sinatra-test

    -cd sinagta-test

    -touch app.rb

    -gem install sinatra

    ```ruby
    #app.rb
    required 'sinatra'


    get '/' do
        "hello world"
    end
    ```

- ruby app.rb -o $IP
        -외부접속을 허용하기 위해서
