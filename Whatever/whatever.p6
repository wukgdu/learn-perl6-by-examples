my @list = (1..20).pick(10);
say @list.grep(* > 10);                  # 返回 @list 数组中所有大于 10 的元素
say @list.grep( -> $ele { $ele > 10 } ); # 同上, 使用显式的闭包
say @list.grep: -> $ele { $ele > 10 };   # 同上, 使用冒号调用方式
say @list.grep: * > 10;                  # 同上
say @list.grep: { $_ > 10 };             # 同上


say @list.map(* + *);                    # 返回 @list 数组中每两个元素的和
say @list.map( -> $a, $b { $a+$b } );    # 同上, 使用显式的闭包
