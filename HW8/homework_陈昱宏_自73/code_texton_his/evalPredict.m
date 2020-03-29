function accuracy = evalPredict(test_samples_labels,test_samples)
accuracy = sum(test_samples_labels.classId==test_samples.classId)/size(test_samples_labels.classId,1);