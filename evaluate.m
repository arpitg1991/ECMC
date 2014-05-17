function [ output ] = evaluate( labels )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

output = 1;

sum(labels==mode(labels(1:500)))
sum(labels==mode(labels(501:1000)))
sum(labels==mode(labels(1001:1500)))
sum(labels==mode(labels(1501:2000)))
sum(labels==mode(labels(2001:2500)))
sum(labels==mode(labels(2501:3000)))

end

