# # {:ok, binary_data} = File.read('input.txt')
# # Why stream! and not just stream ?
# stream = File.stream!('input.txt')
#
# elvesCalorieDatabase = %{}
# largestCalorie = 0
# runningCalorieCount = 0
#
# stream |> Enum.map(fn line ->
#   if Number.parse(line) do
#     {calorie, _} = Number.parse(line)
#     runningCalorieCount += calorie
#     if calorie > largestCalorie do
#       largestCalorie = calorie
#     end
#     Map.put(elvesCalorieDatabase, calorie, 1)
#   end
# end)

# defmodule Elves do
#   largestCalorie = 0
#   runningCalorieCount = 0

#   def find_spaces(line, accumulator) do
#     fixed_line = line |> String.replace("\n", "")

#     result = Integer.parse(fixed_line)

#     if result == :error do
#       if runningCalorieCount > largestCalorie do
#         largestCalorie = runningCalorieCount
#       end

#       runningCalorieCount = 0
#     else
#       {number, _} = result
#       runningCalorieCount = runningCalorieCount + number
#     end
#   end

#   def find_largest_calories() do
#     stream = File.stream!('input.txt')
#     stream |> Enum.map(fn line -> Elves.find_spaces(line) end)
#     IO.puts(largestCalorie)
#   end
# end

# Elves.find_largest_calories()

# ==============================

stream = File.stream!('input.txt')

stream
|> Enum.map(fn line -> String.replace(line, "\n", "") end)
|> Enum.chunk_by(fn x -> x != "" end)
|> Enum.reject(fn x -> x == [""] end)
|> Enum.map(fn elf -> Enum.sum(Enum.map(elf, fn calorie -> String.to_integer(calorie) end)) end)
|> Enum.max()
|> IO.puts()
