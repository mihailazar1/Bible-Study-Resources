from database import get_all_rows_from_sermons_table, get_connection, get_connection_string, get_cursor
from flask import Flask, jsonify

def create_app():
    application = Flask(__name__)

    application.connection_string = get_connection_string()
    application.connection = get_connection(application.connection_string)
    application.cursor = get_cursor(application.connection)

    @application.route("/api/sermons", methods=["GET"])
    def get_sermons():
        rows = get_all_rows_from_sermons_table(application.connection, application.cursor)
        return jsonify(rows)
    
    return application

if __name__ == '__main__':
    app = create_app()
    app.run(host="0.0.0.0", port=80)