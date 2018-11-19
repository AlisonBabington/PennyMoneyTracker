Penny was my first project, a money tracker app built for a week long solo project. It was built for the following brief.

Spending Tracker Build an app that allows a user to track their spending.

MVP The app should allow the user to create, edit and delete merchants, e.g. Tesco, Amazon, ScotRail The app should allow the user to create, edit and delete tags for their spending, e.g. groceries, entertainment, transport The user should be able to assign tags and merchants to a transaction, as well as an amount spent on each transaction. The app should display all the transactions a user has made in a single view, with each transaction's amount, merchant and tag, and a total for all transactions. Inspired by: Monzo, MoneyDashboard, lots of mobile/online banking apps

The project must be built using only:

HTML / CSS Ruby Sinatra PostgreSQL and the PG gem

It must NOT use:

Any Object Relational Mapper (e.g. ActiveRecord) JavaScript. At all. Don't even think about it. Any pre-built CSS libraries, such as Bootstrap. Authentication. Assume that the user already has secure access to the app.

Possible Extensions Transactions should have a timestamp, and the user should be able to view transactions sorted by the time they took place. The user should be able to supply a budget, and the app should alert the user somehow when when they are nearing this budget or have gone over it. The user should be able to filter their view of transactions, for example, to view all transactions in a given month, or view all spending on groceries.
