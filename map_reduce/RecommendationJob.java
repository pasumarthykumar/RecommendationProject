import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class RecommendationJob {

	public static void main(String args[]) throws IOException, ClassNotFoundException, InterruptedException {
		Configuration conf = new Configuration();
		Job job = new Job(conf, "Recommendation Job");

		job.setJarByClass(RecommendationJob.class);
		job.setMapperClass(RecommendationMapper.class);
		job.setReducerClass(RecommendationReducer.class);
		job.setCombinerClass(RecommendationReducer.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);

		// conf.set("mapreduce.output.textoutputformat.separator", ";");

		Path input = new Path(args[0]);
		Path output = new Path(args[1]);

		FileInputFormat.addInputPath(job, input);
		FileOutputFormat.setOutputPath(job, output);

		output.getFileSystem(conf).delete(output, true);

		// FileOutputFormat.setCompressOutput(job,true);
		// FileOutputFormat.setOutputCompressorClass(job, SnappyCodec.class);

		System.exit(job.waitForCompletion(true) ? 0 : 1);
	}
}
