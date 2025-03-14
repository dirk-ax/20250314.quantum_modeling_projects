document.addEventListener('DOMContentLoaded', function() {
    // Tab functionality
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabPanes = document.querySelectorAll('.tab-pane');

    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            // Remove active class from all buttons and panes
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabPanes.forEach(pane => pane.classList.remove('active'));

            // Add active class to clicked button and corresponding pane
            button.classList.add('active');
            const tabId = button.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('nav a');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            const headerHeight = document.querySelector('header').offsetHeight;
            
            window.scrollTo({
                top: targetElement.offsetTop - headerHeight,
                behavior: 'smooth'
            });
        });
    });

    // Form submission handler
    const form = document.getElementById('info-request-form');
    if (form) {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // In a real implementation, this would send the form data to a server
            // For now, we'll just show a success message
            const formData = new FormData(form);
            let formValues = {};
            
            formData.forEach((value, key) => {
                formValues[key] = value;
            });
            
            console.log('Form submitted with values:', formValues);
            
            // Reset the form and show success message
            form.reset();
            
            // Create success message
            const successMessage = document.createElement('div');
            successMessage.className = 'success-message';
            successMessage.innerHTML = `
                <div style="background-color: #2ecc71; color: white; padding: 1rem; border-radius: 4px; margin-top: 1rem;">
                    <p><strong>Thank you for your interest!</strong></p>
                    <p>We've received your request for information about the Axiomatic_AI Education Initiative. 
                    You'll receive more details at the email address you provided.</p>
                </div>
            `;
            
            // Insert the message after the form
            form.parentNode.insertBefore(successMessage, form.nextSibling);
            
            // Remove the message after 5 seconds
            setTimeout(() => {
                successMessage.remove();
            }, 5000);
        });
    }

    // Mobile menu toggle
    const createMobileMenu = () => {
        const header = document.querySelector('header');
        const nav = document.querySelector('nav');
        const navUl = document.querySelector('nav ul');
        
        const menuToggle = document.createElement('button');
        menuToggle.className = 'menu-toggle';
        menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
        menuToggle.style.cssText = `
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            display: none;
        `;
        
        header.querySelector('.container').appendChild(menuToggle);
        
        const mobileBreakpoint = 768;
        
        function checkScreenWidth() {
            if (window.innerWidth <= mobileBreakpoint) {
                menuToggle.style.display = 'block';
                navUl.classList.add('mobile-nav');
                navUl.style.cssText = `
                    position: absolute;
                    top: 100%;
                    right: 0;
                    background-color: #2c3e50;
                    width: 200px;
                    padding: 1rem;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    transform: translateX(100%);
                    transition: transform 0.3s ease;
                    z-index: 1000;
                `;
            } else {
                menuToggle.style.display = 'none';
                navUl.classList.remove('mobile-nav');
                navUl.style.cssText = '';
            }
        }
        
        checkScreenWidth();
        
        window.addEventListener('resize', checkScreenWidth);
        
        menuToggle.addEventListener('click', () => {
            navUl.style.transform = navUl.style.transform === 'translateX(0%)' ? 
                'translateX(100%)' : 'translateX(0%)';
        });
        
        // Close mobile menu when clicking outside
        document.addEventListener('click', (event) => {
            if (
                window.innerWidth <= mobileBreakpoint &&
                navUl.style.transform === 'translateX(0%)' &&
                !nav.contains(event.target) &&
                event.target !== menuToggle
            ) {
                navUl.style.transform = 'translateX(100%)';
            }
        });
    };
    
    createMobileMenu();

    // Logout functionality
    const logoutButton = document.getElementById('logout-btn');
    if (logoutButton) {
        logoutButton.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Clear authentication from session storage
            sessionStorage.removeItem('authenticated');
            
            // Redirect to login page
            window.location.href = 'index.html';
        });
    }
});
