-- 利用元表模拟类
Lib = Lib or {}

Lib._tbCommonMetatable	= {
	__index	= function (tb, key)
		return rawget(tb, "_tbBase")[key];
	end;
};

function Lib:NewClass(tbBase, ...)
	local tbNew	= { _tbBase = tbBase };			-- 基类
	setmetatable(tbNew, self._tbCommonMetatable);
	local tbRoot = tbNew;
	local tbInit = {};
	repeat										-- 寻找最基基类
		tbRoot = rawget(tbRoot, "_tbBase");
		local fnInit = rawget(tbRoot, "init");
		if (type(fnInit) == "function") then
			table.insert(tbInit, fnInit);		-- 放入构造函数栈
		end
	until (not rawget(tbRoot, "_tbBase"));
	for i = #tbInit, 1, -1 do
		local fnInit = tbInit[i];
		if fnInit then
			fnInit(tbNew, unpack(arg));			-- 从底向上调用构造函数
		end
	end
	return tbNew;
end

-- 全局名称
Base = {}

-- 类型定义 start
Base.ONE = 	     1;
Base.TWO =       2;
Base.THREE =     3;
Base.FOUR =      4;
Base.FIVE =      5;
Base.SIX =       6;

Base.TOTAL_NUM = 6;
-- 类型定义 end

Base.tbBaseClasses = Base.tbBaseClasses or {};
local tbBaseClasses = Base.tbBaseClasses;
local tbBaseClass = tbBaseClasses[0] or {};  
tbBaseClasses[0] = tbBaseClass;	--Base.tbBaseClasses[0] 作为基类

-- 定义基类的函数,可以重写
function tbBaseClass:Init()
	print("tbBaseClass[0]")
end

function Base:GetBaseClass(nBaseClassId, szBaseClassName)
	local tbBaseClass = tbBaseClasses[nBaseClassId];

	if (not tbBaseClass) then
		tbBaseClass = Lib:NewClass(tbBaseClasses[0]);
		tbBaseClass.nBaseClassId = nBaseClassId;
		tbBaseClass.szBaseClassName = szBaseClassName;
		tbBaseClasses[nBaseClassId] = tbBaseClass;
	end

	return tbBaseClass;
end

local tbClassOne = Base:GetBaseClass(1, "firstClass");

-- 重写Init函数
function tbClassOne:Init()
	print(self.nBaseClassId, self.szBaseClassName);
end

tbClassOne:Init()
