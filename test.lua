package.path = package.path ..';..\\?.lua'
luaStack = require "luaStack"

--测试代码 
--push 数字
stack1 = luaStack:new()

stack1:push(1)  
stack1:push(2)
stack1:push(3)

while (stack1:Count() > 0)	-- lua中只有nil 和 false 为假
do
	print("stack1 now cotain number:"..stack1:Count())
	print("pop top number:"..stack1:pop())
end

--push 表
stack2 = luaStack:new()

a = {1, 2}
b = {3, 4}
c = {5, 6}

stack2:push(a)
stack2:push(b)
stack2:push(c)

while (stack2:Count() > 0)	-- lua中只有nil 和 false 为假
do
	print("stack1 now cotain table:"..stack1:Count())
	temp = stack1:pop();
	print("pop top table num 1: "..temp[1].." num 2: "..temp[2])
end