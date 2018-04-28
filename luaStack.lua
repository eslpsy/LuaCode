-- lua模拟stack
local stack = {}  
stack.__index = stack  
  
function stack:new()  
    local temp = {}  
    setmetatable(temp,stack) 
    stack:init() 
    return temp  
end  
  
function stack:init()  
    self.stackList = {}  
end  
  
function stack:reset()  
    self:init()  
end  
  
function stack:clear()  
    self.stackList = {}  
end  
  
function stack:pop()  
    if #self.stackList == 0 then  
        return  
    end   
      
    return table.remove(self.stackList)  
end  
  
function stack:push(t)  
    table.insert(self.stackList,t)  
end  
  
function stack:Count()  
    return #self.stackList  
end  

return stack
