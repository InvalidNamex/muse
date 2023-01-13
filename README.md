This app depends on:
- supabase database
- admob
- audd.io API
- tempmail
To initiate project
- Go to supabase follow installation steps by editing .env file with your credentials
- create 2 tables
    1- admobTable (id, bannerAd, interstitialAd) columns
      * add unique ids of the ads in the columns to display them in app all in one row
    2- apiTable(id, apiKey) columns
      * get an apiToken from audd.io using a temp mail for 10 days or pay for one of the plans
      * add the apiToken to table
Enjoy.