dataRegex = /`(.*)` <-\n c\((.*)/im
dataRegex2 = /(.*) <-\n c\((.*)/im
dataNames = Array.new
dataNums = Array.new
lines = Array.new

File.open(ARGV[0], "r") do |infile|
	lines = infile.readlines
end

line = lines.join(" ")
data = line.split(/\)$/)

data.each do |field|
	match = dataRegex.match(field)
	if (!match.nil?) then
		dataNames.push(match[1].strip)
		line = match[2].split("\n").join(" ").squeeze(" ")
		dataNums.push(line.split(", "))
	else
		match = dataRegex2.match(field)
		if (!match.nil?) then
			dataNames.push(match[1].strip)
			line = match[2].split("\n").join(" ").squeeze(" ")
			dataNums.push(line.split(", "))
		end
	end
end

dataNames.insert(0, dataNames[55])
dataNames.delete_at(56)
dataNums.insert(0, dataNums[55])
dataNums.delete_at(56)

puts "#{dataNames.join("\t")}"
dataNums[0].each_index do |i|
	colData = Array.new
	dataNums.each_index do |j|
		colData.push(dataNums[j][i])
	end
	puts colData.join("\t")
end

dataNames.each_index do |i|
	if dataNames[i] == "MouseNum" then 
		$stderr.puts "MouseNum = #{i}"
	end
end