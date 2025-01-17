from flask import Flask, render_template, request, redirect, url_for, make_response
import jwt
import datetime

app = Flask(__name__)

SECRET_KEY = "oyvEgyD2oqPpD1n4iJLVrgkQjnNPasABVvX3Gylj13LDnqWkqbWMnkQE4qz0fbMi"

registered_users = {}

@app.route('/', methods=['GET'])
def index():
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username in registered_users:
            return render_template('register.html', error="Username already exists")

        registered_users[username] = password
        token = jwt.encode(
            {"username": username, "admin": 0, "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)},
            SECRET_KEY,
            algorithm="HS256"
        )
        return render_template('login.html', success="Registration successful!", token=token)

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if username in registered_users and registered_users[username] == password:
            token = jwt.encode(
                {"username": username, "admin": 0, "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)},
                SECRET_KEY,
                algorithm="HS256"
            )
            response = make_response(render_template('user.html', username=username))
            response.set_cookie('token', token, httponly=True, max_age=3600)
            return response

        return render_template('login.html', error="Invalid username or password")

    return render_template('login.html')

@app.route('/user', methods=['GET'])
def user():
    token = request.cookies.get('token')
    if not token:
        return redirect(url_for('login'))

    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return render_template('user.html', username=decoded['username'], is_admin=decoded['admin'])
    except jwt.InvalidTokenError:
        return redirect(url_for('login'))

@app.route('/admin', methods=['GET'])
def admin():
    token = request.cookies.get('token') 
    if not token:
        return """
        <script>
            alert('Access denied: Please log in first.');
            window.location.href = "/login";
        </script>
        """

    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256", "None"])
        if decoded.get('admin') == 1:
            return render_template('admin.html', username=decoded['username'])
        else:
            return """
            <script>
                alert('Access denied: You are not an admin.');
                window.location.href = "/login";
            </script>
            """
    except jwt.InvalidTokenError:
        return """
        <script>
            alert('Invalid token: Please log in again.');
            window.location.href = "/login";
        </script>
        """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
