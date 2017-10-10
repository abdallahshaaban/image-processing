function [ Min Max ] = ChannelMaxAndMin( Image )
Min = min(min(Image));
Max = max(max(Image));
end

