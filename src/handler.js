var aws = require("aws-sdk")

exports.handler = async () => {
    var analytics = new Analytics()
    var data = { some: 'object', some_other: 'value', some_array: ['value1', 'value2', 'value3'] }

    analytics.record(data)
}

class Analytics {
    fh;

    constructor() {
        this.fh = new aws.Firehose();
    }


    record(data) {

        var params = {
            DeliveryStreamName: 'metrics-stream',
            Record: {
                Data: Buffer.from(JSON.stringify(data) + "\n")
            }
        };
        this.fh.putRecord(params, function (err, data) {
            if (err) throw err;
            else console.log(data);
        });
    }
}

this.handler()