function make()
	dofile("F:\\1.lua")

	local binfile = "file.bin"
	local fd = io.open(binfile,"rb")
	local fileStr = fd:read("*a")
	fd:close()
	local flen = #fileStr
	local ReadOutStr = ""
	local offset = 0

	--每次取出512个字符转换成16进制保存成字符串，如果直接取出所有字符堆栈会溢出
	repeat
		local bytes = string.sub(fileStr,offset+1,offset+512)
		for k,v in ipairs({string.byte(bytes, 1,-1)}) do
			ReadOutStr = ReadOutStr..string.format("%02X",v)
		end
		offset = offset + 512
	until offset+1 > flen

	--print("OLDSTR:"..ReadOutStr)
	print("文件长度："..flen)

	local fbstr = FindKm(ReadOutStr, string.len(ReadOutStr))
	print("old km =",fbstr)

	local new_value = 123456		
	local  Newstr =ReplaceKm(ReadOutStr, string.len(ReadOutStr),new_value)
	--print(fbstr)
	km =FindKm(Newstr, string.len(Newstr))
	print("new km ="..km)

	print("Newstr:"..Newstr)

--写入文件
	local path = string.match(binfile, "(.+)\\[^\\]*%.%w+$")
	--print(path)
	local newfd = assert(io.open(path.."\\new.bin","wb"))

	local hex = ""
	for i=1,flen*2,2 do
		hex = asc2hex(Newstr,i) * 16 + asc2hex(Newstr,i+1)
		--print(hex)
		newfd:write(string.char(hex))
	end
	newfd:close()
end


make()
