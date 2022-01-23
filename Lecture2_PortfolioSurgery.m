stock = [1:100];
for i = [1:20]
    for j = [1:100]
        call(i,j) = max(stock(j)-5*i,0);
        put(i,j) = max(5*i - stock(j), 0);
    end
end
plot(call);
plot(put);
call = call';
put = put';
%% portfolio
portfolio = (stock-20).*(stock-40).*(stock-60);
portfolio = portfolio';
%% create explanatory variable
x = [call put];
%% create negative
negative = min(portfolio,0);
%% fit
b = regress(negative,x); 
plot(portfolio);
bar(b);
c = -b;
bar(c);
%% after surgery
aftsurg = portfolio - x*b;
plot(stock,portfolio);
hold on
plot(stock,aftsurg);
%% piecewise linear approx
optionpayoff = x*b;
plot(stock, portfolio);
hold on
plot(stock, optionpayoff);