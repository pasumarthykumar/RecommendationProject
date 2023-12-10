import java.io.IOException;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class RecommendationReducer extends Reducer<Text, Text, Text, Text> {
	public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
		//int len = 1683;
		int len = 100;
		int ar[] = new int[len];
		for (Text val : values) {
			String a[] = val.toString().split("\t");
			int it = Integer.parseInt(a[0].toString());
			if (it < len) {
				ar[it] = 1;
				context.write(key, val);
			}
		}
		for (int i = 1; i < len; i++) {
			if (ar[i] == 0)
				context.write(key, new Text(Integer.toString(i) + "\t" + "0"));
		}
	}
}