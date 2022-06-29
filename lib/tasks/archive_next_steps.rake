


task :archive_next_steps => :environment do
  puts "Coping Next Steps..."

  Case.where.not(next_steps: nil).each do |tcase|
    archived_steps = tcase.archived_step&.split("\n") || []
    archived_steps << "#{Date.today.to_s} - #{tcase.next_steps} "
    puts archived_steps.join("\n")
    tcase.update(archived_step: archived_steps.join("\n"))
  end
end
