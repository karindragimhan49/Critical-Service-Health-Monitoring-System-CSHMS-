from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/health')
def health_check():
    """Health check endpoint to show the service is running."""
    return jsonify({"status": "OK"}), 200

@app.route('/')
def home():
    """Main endpoint."""
    pid = os.getpid()
    return f"<h1>Hello! I am the Critical Service.</h1><p>My Process ID (PID) is: {pid}</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)