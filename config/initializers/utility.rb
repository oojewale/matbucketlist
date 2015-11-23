def time_parser(time_data)
  time_data.to_datetime.strftime("%Y-%m-%d %H:%M:%S")
end