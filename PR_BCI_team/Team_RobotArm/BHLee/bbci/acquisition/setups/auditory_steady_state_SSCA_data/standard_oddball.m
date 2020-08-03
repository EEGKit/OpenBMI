function [seq] = standard_oddball(rate,interval,duration)
%Erzeugt eine zuf�llige Sequenz von einem Target und einem Non-Target Ton
%in einem bestimmten Verh�ltnis(rate)
%   IN
%       rate        Verh�ltnis 1/rate
%       intervall   Abstand der T�ne in ms
%       duration    Dauer der Messung in Minuten
%   OUT
%       seq     zuf�llige Sequenz

parts= round(((duration*60*1000)/interval))/rate;

seq = [];

for int=1:parts
    
for i=1:rate
   tmp_seq(i)=1; 
end
    index = randi(rate);
    while index == 1
        index = randi(rate);
    end
    tmp_seq(index) = 2;
    seq=cat(2,seq,tmp_seq);
end

end