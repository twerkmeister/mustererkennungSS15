function intersection = gaussIntersect(m1, m2, std1, std2)
  if(m1 > m2)
    intersection = gaussIntersect(m2, m1, std2, std1);
  else
    if(std1 == std2)
      intersection = mean(m1,m2);
    else
      intersection = (std2**2*m1 - std1**2*m2 + std1*std2 * sqrt((m1-m2)**2 + 2*(std2**2 - std1**2) * log(std2/std1))) / (std2**2 - std1**2)
    end
  end