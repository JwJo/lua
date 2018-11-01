module("common.bit", package.seeall)
 
local bitLen = 32
 
local function numberToBits(src)
  local result = {}
  for i = 1, bitLen do
    result[i] = src % 2
    src = math.floor(src / 2)
  end
 
  return result
end
 
local function bitsToNumber(src)
  local result = 0
  for i = 1, bitLen do
    if src[i] == 1 then
      result = result + 2 ^ (i - 1)
    end
  end
 
  return result
end
 
function SetBitLen(len)
  bitLen = len
end
 
function GetBitLen(len)
  return bitLen
end
 
function Lsl(src, dst)
  return src * 2 ^ dst
end
 
function Lsr(src, dst)
  return math.floor(src / 2 ^ dst)
end
 
function Xor(src, dst)
  local srcBit = numberToBits(src)
  local dstBit = numberToBits(dst)
  local result = {}
 
  for i = 1, bitLen do
    result[i] = (srcBit[i] == dstBit[i] and 0 or 1)
  end
 
  return bitsToNumber(result)
end
 
function And(src, dst)
  local srcBit = numberToBits(src)
  local dstBit = numberToBits(dst)
  local result = {}
 
  for i = 1, bitLen do
    result[i] = ((srcBit[i] == dstBit[i] and srcBit[i] == 1) and 1 or 0)
  end
 
  return bitsToNumber(result)
end
 
function Or(src, dst)
  local srcBit = numberToBits(src)
  local dstBit = numberToBits(dst)
  local result = {}
 
  for i = 1, bitLen do
    result[i] = ((srcBit[i] == dstBit[i] and srcBit[i] == 0) and 0 or 1)
  end
 
  return bitsToNumber(result)
end
 
function Not(src)
  local srcBit = numberToBits(src)
  for i = 1, bitLen do
    srcBit[i] = (srcBit[i] == 1 and 0 or 1 )
  end
 
  return bitsToNumber(srcBit)
end
 
function HexStringToNumber(hexString, isBigEndian)
  local result = ""
  if not isBigEndian then
    local count = math.floor(string.len(hexString) / 2)
    while count > 0 do
      local index = count * 2 - 1
      result = result .. string.sub(hexString, index, index + 1)
      count = count - 1
    end
  else
    result = hexString
  end
 
  return tonumber(result, 16)
end
--------------------- 
作者：RexGene 
来源：CSDN 
原文：https://blog.csdn.net/RexGene/article/details/41045459 
版权声明：本文为博主原创文章，转载请附上博文链接！
