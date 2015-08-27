module CdbBatchProjectsHelper
	def new_cd_batch_projects params
		project = params[:project_id]
		cd_batches = params[:cdb_batch_id].gsub(/\s+/, "")
		create_list = []	

		# If it's just a number. 
		if is_number? cd_batches
			create_list.push cd_batches.to_i
		elsif is_list? cd_batches
			comma_seperated_numbers = cd_batches.split(',')
			
			comma_seperated_numbers.each do |seq|
				if is_number? seq
					# Add the number to the array.
					create_list.push seq.to_i
				else
					# Split the number into a start and end, then push all the numbers between them to the array.
					seq_start, seq_end = seq.split('-')
					seq_start = seq_start.to_i
					seq_end = seq_end.to_i
					# Makes sure seq_start is actually the start. 
					if seq_start > seq_end
						temp = seq_start
						seq_start = seq_end
						seq_end = temp
					end

					(seq_start..seq_end).each do |n| create_list.push n end
				end
			end
		else
			#ERROR
		end
		puts create_list
		results = []
		create_list.each do |cd_batch|
		  results.push CdbBatchProject.create project_id: project, cdb_batch_id: cd_batch
		end
		results
	end

	def is_number? input
		/\A\d+\z/.match(input)
	end

	def is_list? input
		# Ensures only , and | are between digits, and that the sequence starts and ends with a digit. 
		/\A(\d+(,|-))+\d+\Z/.match(input)
	end
end
