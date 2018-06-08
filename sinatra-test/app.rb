require 'sinatra'
require "sinatra/reloader"
require 'rest-client'
require 'json' #json>hash
require 'httparty'
require 'nokogiri'
require 'uri'
require 'date'
require 'csv'

before do
    p "***********"
    p params
    p request.path_info
    p request.fullpath
    p "***********"
end

get '/' do
  'Hello world! welcome'
end

get '/htmlfile' do
    send_file 'views/htmlfile.html'
end

get '/htmltag' do
    '<h1>html태그를 보낼 수 있습니당</h1>
    <ul>
    <li>1</li>
    <li>11</li>
    </ul>
    '
end

get '/welcome/:name' do
    "#{params[:name]}님안녕하세요"
end

get '/cube/:num' do
    input=params[:num].to_i
    result=input ** 3
    
    "<h1>#{result}</h1>"
    
    "#{params[:num].to_i ** 3}"
end

get '/erbfile' do
    @name ="me"
    erb :erbfile
end

get '/dinner-array' do
    #메뉴들을 배열에 저장한당
    #하나를 추천한다
    #erb파일에 담아서 렌더링한다
    #@를 붙인것들만,뷰파일에서 사용할수 있다!(인스턴스변수)
    menu=["그냥밥","고기","찌개"]
    @menurd=menu.sample
    erb :lunch
end


get '/lunch-hash' do
    #메뉴들이 저장된 배열을 만든다
    #메뉴이름(key) 사진url(value)을 가진 해쉬를 만든다
    #랜덤으로 하나 출력
    #이름과 url을 넘겨서 erb를 렌더링한다
    
    menu=["bab","gogi","soup"]
    menu_Img={
        "bab"=>"http://snacker.hankyung.com/wp-content/uploads/2015/06/%EB%B0%A501.jpg",
        "gogi"=>"data:image/jpeg;base64,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",
        "soup"=>"https://static01.nyt.com/images/2016/11/29/dining/recipelab-chick-noodle-still/recipelab-chick-noodle-still-videoSixteenByNineJumbo1600.jpg"
    }
    @menurandom=menu.sample
    @menu_Img=menu_Img[@menurandom] #key에 접근
    erb :lunchhash
end

#day2

get '/randomgame' do
    list=["what","i","wanna","tell","you"]
    list_Img={
        "what"=>"http://img.etoday.co.kr/pto_db/2017/12/20171207095114_1161337_710_340.jpg",
        "i"=>"https://ncache.ilbe.com/files/attach/new/20180108/377678/411676640/10276428416/dfee83ec5baaa464e9b84b1cbec9a469.jpg",
        "wanna"=>"http://bingstory2.iptime.org/Exo/AppImg5//g88554473.png",
        "tell"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlKbukbTq5wqvjKPIPCWIthZdH42x5yAEizRxMHty1ekFGDII6",
        "you"=>"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-LOAevOn9wtMAdaPpIQg601aPMKE_NOSYLCgWq_yPZj4221k-qw"
    }
    @listrandom=list.sample
    @list_Img=list_Img[@listrandom]
    erb :list
end


get '/lotto' do
    @lotto=(1...45).to_a.sample(6)    #(range).array로바꿈.샘플링
    url="http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809" #json
   
    @lotto_info=RestClient.get(url)
    @lotto_hash=JSON.parse(@lotto_info)
    @winner=[]
    @lotto_hash.each do |k,v|
        if k.include?('drwtNo')
            #배열에 저장
            #@winner.push 
            @winner << v
        end
    end
    
    #winner와 lotto 비교하여, 몇개가 일치하는지
    @matchnum= (@lotto&@winner).length
    @bonusnum=@lotto_hash["bnusNo"]
    
    
    # if @matchnum==6
    #     @result="1등"
    # elsif(@matchnum==5 && @lotto.include?(@bonusnum))
    #     @result="2등"
    # elsif(@matchnum==5) then @result="3등"
    # elsif(@matchnum==4)
    #     @result="4등"
    # elsif(@matchnum==3)
    #     @result="5등"
    # else
    #     @result="꽝"
    # end
    
    case [@matchnum, @lotto.include?(@bonusnum)]
    when [6, false] then @result="1등"
    when [6, true] then @result="2등"    
    when [6, false] then @result="3등"
    when [6, false] then @result="4등"
    when [6, false] then @result="5등"
    else @result="loser" 
    end
    erb :lottosample #erb rendering
end

get '/form' do
    erb :form
end

get '/search' do
    @keyword = params[:keyword]
    url='https://search.naver.com/search.naver?query='
    #erb :search
    redirect to (url +@keyword)
end

get '/opgg' do
    erb :opgg
end

get '/opggresult' do
    url='http://www.op.gg/summoner/userName='
    @userName = params[:userName]
    @encodeName=URI.encode(@userName)
    @res=HTTParty.get(url+@encodeName)
    @doc=Nokogiri::HTML(@res.body)
    
    @win =@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins")
    @lose =@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses")
    @rank =@doc.css("#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierRank > span")
    
    erb :opggresult
end

